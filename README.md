# Apache Directory Index Resource

A Concourse resource for the apache directory index.

## Source Configuration

```yaml
resource_types:
- name: apache-directory-index
  type: docker-image
  source:
    repository: mastertinner/apache-directory-index-resource

resources:
- name: tomcat-7
  type: apache-directory-index
  source:
    host: https://archive.apache.org
    path: /dist/tomcat/tomcat-7
    regexp: v(.*)/
    file: bin/apache-tomcat-*.exe
```

* `host` is the host of your Apache server
* `path` is the path of where the your versioned folders reside
* `regexp` is a regexp of the semver versions to be checked
* `file` is the file to download (relative path to the versioned folder it resides in)

## Behavior

### `check`: Check for new folders

Checks if there are new versions of the source.

### `in`: Download a version

Downloads the latest source's file.

### `out`: Upload a version (not implemented)

Creates a new version and uploads its file.

## Example

```yaml
jobs:
- name: download-tomcat-7
  plan:
  - get: tomcat-7
    trigger: true
```
