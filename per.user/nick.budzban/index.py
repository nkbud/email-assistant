import json
import logging
import os
from typing import Optional,List
import re
from aws_xray_sdk.core import xray_recorder
from aws_xray_sdk.core import patch_all

logger = logging.getLogger()
logger.setLevel(logging.INFO)
patch_all()


def all_substrs(substring: str, string: str, start=0, accum=[]):
    """
    Return all indices of the substring in the string
    """
    idx = string.find(substring, start)
    if idx < 0:
        return accum
    
    accum.append(idx)
    return all_substrs(substring, string, idx + 1, accum=accum)


def all_captures(pattern: re.Pattern,string: str,start=0):
    """
    string = "The price is $100."
    pattern = r"(\w+) is \$(\d+)"
    [("The price", "100")]
    """
    list_of_captures = re.findall(pattern, string)
    

class Capture:

    def __init__(self, a, b):
        self.a = a
        self.b = b
        
    
class EmailHandler:

    def __init__(self, content):
        self.content = content

    def extract_objects(self, content):
        """
        1. substring (<html> ... </html>)
        2. substring (username, password, login link)
        :return:
        """
        objs = []
        obj = Capture(a="a", b="b")
        objs.append(obj)
        return None
    
    
def handler(event, context):
    """
    event = {
      "a": "John",
      "b": "Doe",
    }
    """
    logger.info("ENV: " + os.environ)
    logger.info("EVENT: " + event)
    
    message = 'Hello {} {}!'.format(event['a'], event['b'])

    return {
        "statusCode":200,
        "headers":{
            "Content-Type":"application/json"
        },
        "body": json.dumps({
            "Message": message
        })
    }