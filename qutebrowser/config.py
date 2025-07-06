config.load_autoconfig(False)

# search enginesa
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'g': 'https://www.google.com/search?q={}',
    'gh':'https://github.com/search?q={}&type=repositories',
    'w':'https://en.wikipedia.org/w/index.php?search={}&title=Special%3ASearch&ns0=1',
    'y':'https://www.youtube.com/results?search_query={}',
    'f':'https://www.facebook.com/marketplace/sorocaba/search/?query={}',
    'o':'https://www.olx.com.br/brasil?q={}',
    'aw':'https://wiki.archlinux.org/title/{}',
    'jad':'http://www.jadlog.com.br/tracking?cte={}',
    'aur':'https://aur.archlinux.org/packages?O=0&SeB=nd&K={}&outdated=&SB=p&SO=d&PP=50&submit=Go',
    'rdt': 'https://www.reddit.com/search/?q={}&cId=ea692ef8-56df-4104-901c-4a92de6b2ae1&iId=28e5506d-8c3e-4345-ae03-9e1912291b32'
}

c.completion.shrink = True
c.url.start_pages = ["https://google.com"]
c.auto_save.session = True
c.completion.use_best_match = True
# c.confirm_quit = ConfirmQuit.always
c.content.geolocation = 'ask'
c.content.javascript.clipboard = 'access-paste'

# aliases
c.aliases = {
    'yt': 'open -t https://youtube.com',
    'mail': 'open -t https://mail.google.com/mail/u/0/#inbox',
    'disc': 'open -t https://discord.com/app',
}

# binds
config.bind('<Ctrl-1>', 'tab-focus 1')
config.bind('<Ctrl-2>', 'tab-focus 2')
config.bind('<Ctrl-3>', 'tab-focus 3')
config.bind('<Ctrl-4>', 'tab-focus 4')
config.bind('<Ctrl-5>', 'tab-focus 5')
config.bind('<Ctrl-6>', 'tab-focus 6')
config.bind('<Ctrl-7>', 'tab-focus 7')
config.bind('<Ctrl-8>', 'tab-focus 8')
config.bind('<Ctrl-9>', 'tab-focus 9')
config.bind('<Ctrl-0>', 'tab-focus 0')
config.bind('d', 'scroll-page 0 0.5')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('<Ctrl-u>', 'undo')
config.bind('<Ctrl-l>', 'cmd-set-text :open {url:pretty}')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
