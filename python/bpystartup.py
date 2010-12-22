# Make bpython load django environment and modules if
# you are running bpython from a django project dir

# Load django environment and modules
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
