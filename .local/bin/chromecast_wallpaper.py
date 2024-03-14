#!/bin/python3

import json
import re
import socket
import subprocess
import sys
import time
import threading
import urllib.request

def help():
    print('Usage:')
    print('\tpython chromecast_wallpaper.py <option>')
    print('Options:')
    print('\tstart\t\tStart server for listen options')
    print('\tprev\t\tChange to previous wallpaper')
    print('\tnext\t\tChange to next wallpaper')
    print('\tstop\t\tStop and exit server')
    print('\tstandalone\tRun chromecast_wallpaper standalone')


def stubborn(function):
    def wrapper(*args, **kwargs):
        while True:
            try:
                result = function(*args, **kwargs)
                break
            except Exception as ex:
                time.sleep(5)

        return result

    return wrapper


class ChromecastWallpaper():
    CHROMECAST_HOME ='https://clients3.google.com/cast/chromecast/home'

    def __init__(self, speed=60):
        self.speed = speed
        self.wallpapers = []
        self.current_wallpaper = -1
        self.kill = threading.Event()

    def start(self):
        while not self.kill.is_set():
            self.next_wallpaper()
            self.kill.wait(self.speed)

    def stop(self):
        self.kill.set()

    @stubborn
    def refresh_wallpapers(self):
        request = urllib.request.Request(ChromecastWallpaper.CHROMECAST_HOME.replace('https', 'http'))
        response = urllib.request.urlopen(request)
        data = response.read().decode('utf-8')
        text = re.search("JSON\.parse\('(.+?)'\)\)\.", data).group(1)
        text = eval("'{}'".format(text))
        data = json.loads(text)

        self.wallpapers = []
        self.current_wallpaper = -1

        for [url, author, *_] in data[0]:
            self.wallpapers.append({'url': url, 'author': author})

    @stubborn
    def next_wallpaper(self):
        if not self.wallpapers or self.current_wallpaper >= len(self.wallpapers):
            self.refresh_wallpapers()

        self.change_wallpaper(self.current_wallpaper + 1)

    @stubborn
    def prev_wallpaper(self):
        if self.current_wallpaper < 1:
            return

        self.change_wallpaper(self.current_wallpaper - 1)

    def change_wallpaper(self, index):
        self.current_wallpaper = index
        wallpaper = self.get_current_wallpaper()
        urllib.request.urlretrieve(wallpaper['url'].replace('https', 'http'), '/tmp/wallpaper')
        subprocess.run(['hsetroot', '-solid', '#101010',  '-fill', '/tmp/wallpaper', '-tint', '#ccc'])

    def get_current_wallpaper(self):
        return self.wallpapers[self.current_wallpaper]


class ChromecastWallpaperSocket():
    SERVER_ADDRESS = ('127.0.0.1', 56789)

    def __init__(self, chromecast_wallpaper):
        self.chromecast_wallpaper = chromecast_wallpaper
        self.kill = threading.Event()
        self.actions = {
            b'next': self.chromecast_wallpaper.next_wallpaper,
            b'prev': self.chromecast_wallpaper.prev_wallpaper,
            b'stop': self.stop
        }

    def start(self):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.bind(ChromecastWallpaperSocket.SERVER_ADDRESS)
            s.listen(1)

            while not self.kill.is_set():
                connection, address = s.accept()

                with connection:
                    while True:
                        data = connection.recv(1024)
                        if not data: break
                        result = self.exec_action(data)
                        connection.send(bytes(str(result), 'utf-8'))

    def stop(self):
        self.chromecast_wallpaper.stop()
        self.kill.set()

    def exec_action(self, action):
        action = self.actions.get(action)
        if not action: return False
        action()
        return True

    @staticmethod
    def send_action(action):
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.connect(ChromecastWallpaperSocket.SERVER_ADDRESS)
                s.send(bytes(action, 'utf-8'))
                data = s.recv(1024)

                if data != b'True':
                    raise Exception(f'Option "{action}" not found')
        except Exception as ex:
            help()
            print('-'*60)
            print(ex, ChromecastWallpaperSocket.SERVER_ADDRESS)


def main(option):
    if option == 'start':
        chromecast_wallpaper = ChromecastWallpaper(speed=600)
        chromecast_wallpaper_socket = ChromecastWallpaperSocket(chromecast_wallpaper)

        threading.Thread(target=chromecast_wallpaper.start).start()
        threading.Thread(target=chromecast_wallpaper_socket.start).start()
    elif option == 'standalone':
        chromecast_wallpaper = ChromecastWallpaper(speed=600)
        chromecast_wallpaper.start()
    elif option == 'help':
        help()
    else:
        ChromecastWallpaperSocket.send_action(option)


if __name__ == '__main__':
    if len(sys.argv) < 2:
        help()
    else:
        main(sys.argv[1])

