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
    directory: https://archive.apache.org/dist/tomcat/tomcat-7/
    folder_pattern: v$VERSION
    file_pattern: bin/apache-tomcat-$VERSION.tar.gz
```

* `directory` is the path of where the your versioned folders reside
* `folder_pattern` describes the pattern of how the folders are named (use `$VERSION` as a placeholder for the version)
* `file_pattern` describes the pattern of where the file resides and how it's named (use `$VERSION` as a placeholder for the version)

*Important*: Your version needs to follow the `version_pattern` defined in <scripts/check> (e.g. `1.2.3-beta.4`).

## Behavior

### `check`: Check for new folders

Checks if there are new versions of the source.

### `in`: Download a version

Places the following files in the destination:

* `(filename)`: The file fetched from the directory index
* `url`: A file containing the URL of the file
* `version`: The version identified in the file name

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
