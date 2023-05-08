#!/usr/bin/env python3
# -*- coding:utf-8 -*-

import requests
from bs4 import BeautifulSoup

def htmlfile(path):
    with open(path) as file:
        return file.read()

def checkmachine(link):
    return True

req = requests.get(url="http://nvtest/main/machines/")
req.encoding = "utf-8"
#html = req.text
html = htmlfile("/home/zhujie/xx.html")

soup = BeautifulSoup(html, features="html.parser")
table = soup.find("table", id="machines_table")
for row in table.find_all("tr"):
    td = row.find("td", class_="name")
    if td is not None and td.find("a", href=True):
        if checkmachine(td.find("a")["href"]):
            print(td.text) 
