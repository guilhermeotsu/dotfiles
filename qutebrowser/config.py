config.load_autoconfig(False)

# search engines
c.url.searchengines['g'] = 'https://www.google.com/search?q={}'
c.url.searchengines['gh'] = 'https://github.com/search?q={}&type=repositories'
c.url.searchengines['w'] = 'https://en.wikipedia.org/w/index.php?search={}&title=Special%3ASearch&ns0=1'
c.url.searchengines['y'] = 'https://www.youtube.com/results?search_query={}'
c.url.searchengines['f'] = 'https://www.facebook.com/marketplace/sorocaba/search/?query={}'
c.url.searchengines['o'] = 'https://www.olx.com.br/brasil?q={}'
c.url.searchengines['aw'] = 'https://wiki.archlinux.org/title/{}'
c.url.searchengines['jad'] = 'http://www.jadlog.com.br/tracking?cte={}'

c.completion.shrink = True
c.url.start_pages = ["https://google.com"]
c.auto_save.session = True
c.completion.use_best_match = True
# c.confirm_quit = ConfirmQuit.always
c.content.geolocation = 'ask'
c.content.javascript.clipboard = 'access-paste'

# c.bindings.default = {"normal": {"d": "scroll-page 0 0.5"}}

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
config.bind('<Ctrl-l>', 'cmd-set-text :open {url:pretty}')
