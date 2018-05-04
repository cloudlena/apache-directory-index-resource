# Apache Directory Index Resource

![Docker Build Status](https://img.shields.io/docker/build/mastertinner/apache-directory-index-resource.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/mastertinner/apache-directory-index-resource.svg)

A Concourse resource for the Apache Directory Index.

## Source Configuration

```yaml
resource_types:
- name: apache-directory-index
  type: docker-image
  source:
    repository: mastertinner/apache-directory-index-resource

resources:
- name: tomcat-8
  type: apache-directory-index
  source:
    directory: https://archive.apache.org/dist/tomcat/tomcat-8/
    folder_pattern: v$VERSION
    file_pattern: bin/apache-tomcat-$VERSION.tar.gz
```

* `directory` is the path of where the your versioned folders reside
* `folder_pattern` describes the pattern of how the folders are named (use `$VERSION` as a placeholder for the version)
* `file_pattern` describes the pattern of where the file resides and how it's named (use `$VERSION` as a placeholder for the version)

*Important*: Your version needs to follow the `version_pattern` defined in <scripts/check> (e.g. `1.2.3-beta.4`).

## Behavior

### `check`: Check for new versions

Checks if there are new versions of the source.

### `in`: Download a version

Places the following files in the destination:

* `(filename)`: The file fetched from the directory index
* `url`: Contains the URL of the downloaded file
* `version`: The version identified in the file name

## Example

```yaml
jobs:
- name: download-tomcat-8
  plan:
  - get: tomcat-8
    trigger: true
```
