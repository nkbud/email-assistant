from typing import Optional
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


def authenticate(content: List[str], sender: str):
    """
    1. find the beginning of the authentication section
    2. within the section look for the dmarc=pass && sender@address
    """
    lines = content.splitlines(keepends=False)
    idx = lines.index("Authentication-Results: amazonses.com;")
    for i in range(idx + 1, len(lines)):
        line = lines[i]
        if line.startswith(" dmarc=pass ") and line.endswith(sender):
            return True
        if not line.startswith(" "):
            # this ends the authentication results
            break
    return False
    
    
class EmailHandler:

    def __init__(self, content):
        self.content = content

    def authenticate(self, sender: str):
        """
        1. find the beginning of the authentication section
        2. within the section, look for the dmarc=pass && amazonappstream.com
        """
        lines = self.content.splitlines(keepends=False)
        idx = lines.index("Authentication-Results: amazonses.com;")
        for i in range(idx + 1, len(lines)):
            line = lines[i]
            if line.startswith(" dmarc=pass ") and line.endswith(sender):
                return True
            if not line.startswith(" "):
                # this ends the authentication results
                break
        return False

    def extract_objects(self, content) -> Optional[ParsedInvite]:
        """
        1. substring (<html> ... </html>)
        2. substring (username, password, login link)
        :return:
        """
        objs = []
        obj = Obj(a="a", b="b")
        objs.append(obj)
    
    
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