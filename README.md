# Merge on merge

## Workflows

- Contributors create PRs with input files in specified folder e.g. `/input/blah.json`.
- Github Actions run and create comment with output file change preview
- When merged, the output json file will be modified, and input files will be moved to processed folder
- The action could preview how the target file will look like after appending using comments within PRs.
<!--%%% APPEND_ON_MERGE: Puts above this line %%%-->

## Usage

- Copy [.github/workflows/merge_on_merge.yml](./.github/workflows/merge_on_merge.yml) to your repo
- Change default values to 
- Add instruction to create pull request in input folder instead:

```markdown
- Do not modify data.json directly (It's managed by merge_on_merge GitHub action)
- Create an entry file in input folder with [this link](https://github.com/you/your-awesome-repo/new/main?filename=input/) and use this format.

{
  "name": "narze",
  "occupation": "developer"
}

- Open Pull Request
```

License: MIT
