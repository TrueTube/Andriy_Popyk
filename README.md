# Andriy_Popik

DataLad "version" of the Андрій Попик YouTube channel serving a prototype/test-bed for establishing collection/update of videos from YouTube with subtitles etc.

You would need [git-annex](https://git-annex.branchable.com/) with or without [DataLad](https://datalad.org) 
and [youtube-dl](https://github.com/ytdl-org/youtube-dl) to be able to fetch video files.

Moreover you would need to run

```
git config annex.security.allowed-ip-addresses all
```

to allow `git-annex` to download using youtube-dl.

You would also need to set locally or globally

```
git config core.quotePath false
```

to see proper unicode filenames in output of `git` commands.
