import os
import pipes

os.environ['PATH'] = '/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/share/npm/bin:'

def postBuild(site):
    os.system(
        'sass -t compressed --update %s/static/css/*.sass' % 
            pipes.quote(site.paths['build']
    ))
