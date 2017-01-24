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
    directory: dist/tomcat/tomcat-7/
    folder_pattern: v$VERSION
    file_pattern: bin/apache-tomcat-$VERSION.tar.gz
```

* `host` is the host of your Apache server
* `directory` is the path of where the your versioned folders reside
* `folder_pattern` describes the pattern of how the folders are named (use `$VERSION` as a placeholder for the semver version)
* `file_pattern` describes the pattern of where the file resides and how it's named (use `$VERSION` as a placeholder for the semver version)

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
