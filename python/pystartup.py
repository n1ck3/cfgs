# Add auto-completion and a stored history file of commands to your Python
# interactive interpreter.
#
# Requires: Python 2.0+, readline.
#
# Store the file as ~/.pystartup, and set an environment variable to point
# to it:  "export PYTHONSTARTUP=$HOME/.pystartup" in your shell.
#
# Note that PYTHONSTARTUP does *not* expand "~" -nub-, so you have to put in
# the full path to your home directory.

import atexit
import os.path

# Load Django modules
try:
    from django.core.management import setup_environ
    import settings
    setup_environ(settings)
    print 'imported django settings'
    try:
        exec_strs = ["from %s.models import *" % apps for apps in settings.INSTALLED_APPS]
        for x in exec_strs:
            try:
                exec(x)
            except:
                print 'Not imported for %s' % x
        print 'imported django models'
    except:
        pass
except:
    pass


# Auto Complete
try:
    import readline
except ImportError:
    pass
else:
    import rlcompleter

    class IrlCompleter(rlcompleter.Completer):
        """
        This class enables a "tab" insertion if there's no text for
        completion.

        The default "tab" is four spaces. You can initialize with '\t' as
        the tab if you wish to use a genuine tab.

        """

        def __init__(self, tab='    '):
            self.tab = tab
            rlcompleter.Completer.__init__(self)


        def complete(self, text, state):
            if text == '':
                readline.insert_text(self.tab)
                return None
            else:
                return rlcompleter.Completer.complete(self,text,state)


    #you could change this line to bind another key instead tab.
    readline.parse_and_bind('tab: complete')
    readline.set_completer(IrlCompleter('\t').complete)


# Restore our command-line history, and save it when Python exits.
history_path = os.path.expanduser('~/.pyhistory')
if os.path.isfile(history_path):
    readline.read_history_file(history_path)
atexit.register(lambda x=history_path: readline.write_history_file(x))
