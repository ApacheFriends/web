# ApacheFriends Website

The Apache Friends website is based on [Middleman](https://middlemanapp.com/).

## Requirements

- Docker
- Docker compose

## TL;DR;

```console
$ docker compose run --rm middleman bundle exec middleman build
```

The static website is built at the `build/` folder.

## Building the XAMPP htdocs dashboard

```console
$ docker compose run --rm middleman scripts/build-htdocs-xampp.sh
$ ls xampp-htdocs-*gz
xampp-htdocs-linux-20261029.tar.gz  xampp-htdocs-osx-20261029.tar.gz  xampp-htdocs-stackman-20261029.tar.gz  xampp-htdocs-windows-20261029.tar.gz
```

It can be also built in github by pushing a tag with the date:

```
$ git tag 20261029
$ git push origin 20261029
```

## License

Copyright &copy; 2022 Apache Friends

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
