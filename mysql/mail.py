#! /usr/bin/python

import sys
import optparse
import os
import smtplib
from email.mime.text import MIMEText

## mail server config
mail_host="mail.51ping.com"
mail_user="info"
mail_pass="chinese1"
mail_postfix="51ping.com"
######################

def send_mail(to_list,sub,content):
    me=mail_user+"<"+mail_user+"@"+mail_postfix+">"
    msg = MIMEText(content)
    msg['Subject'] = sub
    msg['From'] = me
    msg['To'] = ";".join(to_list)
    try:
        s = smtplib.SMTP()
        s.connect(mail_host)
        s.login(mail_user,mail_pass)
        s.sendmail(me, to_list, msg.as_string())
        s.close()
        return True
    except Exception, e:
        print str(e)
        return False
mail_to_list=["zxmever@gmail.com"]

msg=sys.argv[2]
msg=msg.replace("\\n","\r\n")
print msg
send_mail(mail_to_list,sys.argv[1],msg)