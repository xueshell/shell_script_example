# svn-export
svn export made easy.

### Usage
```shell
$ svn-export -h
Usage: svn-export REV [PATH]
Exports a clean directory tree from the repository at revision REV,
into PATH. If PATH is omitted, export/REV/ is used for the
local directory name.

```

```shell
$ svn-export 113
exporting to: /srv/projects/svn-test/export/113
 ⇒ /srv/projects/svn-test/export/113/application/modules/site/controllers/TestController.php
 ⇒ /srv/projects/svn-test/export/113/application/modules/site/views/scripts/test/index.phtml
 ⇒ /srv/projects/svn-test/export/113/application/modules/site/views/scripts/test/test.phtml
 ⇒ /srv/projects/svn-test/export/113/application/modules/site/views/scripts/index/index.phtml
 ⇒ /srv/projects/svn-test/export/113/public/css/site/site.css
 ⇒ /srv/projects/svn-test/export/113/public/images/square.checked.png
 ⇒ /srv/projects/svn-test/export/113/public/images/square.png
 ⇒ /srv/projects/svn-test/export/113/public/js/site/site.js

```

### License
None. Use it as you wish :sparkles:
