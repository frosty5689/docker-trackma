import os
from trackma.accounts import AccountManager
from trackma import utils
from envparse import env

username = env.str('ACCOUNT_USERNAME')
password = env.str('ACCOUNT_PASSWORD')
api = env.str('ACCOUNT_API')

manager = AccountManager()

if len(manager.get_accounts()) == 0:
    print("No accounts found, adding account...")
    manager.add_account(username, password, api)
    manager.set_default(1)
else:
    account_exists = False
    for num, account in manager.get_accounts():
        if account["username"] == username and account["api"] == api:
            account_exists = True
            if account["password"] != password:
                print("Account password mismatch, updating...")
                manager.edit_account(num, username, password, api)
            if manager.get_default() != manager.get_account(num):
                print("Setting account as default")
                manager.set_default(num)
            break
    if not account_exists:
        print ("Could not find account, adding account...")
        manager.add_account(username, password, api)
        manager.set_default(len(manager.get_accounts()))

config_path = utils.to_config_path('config.json')

try:
    config = utils.parse_config(config_path, utils.config_defaults)
except IOError:
    raise utils.EngineFatal("Couldn't open config file.")

for key, value in config.items():
    config[key] = env(key.upper(), cast=type(value), default=value)

utils.save_config(config, config_path)

