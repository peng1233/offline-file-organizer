# Offline push fallback (Git bundle)

If your network cannot `git push` to GitHub reliably (e.g. `github.com:443 connection reset`), you can export the unpushed commits into a single **.bundle** file, then upload/apply it later from a stable network.

## 1) Export bundle (on the machine with the commits)

From the repo root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\git-export-bundle.ps1
```

Output bundles are saved under `./bundles/`.

## 2) Import bundle (on a machine with stable network)

Copy the `.bundle` file to the other machine, then:

```powershell
git clone https://github.com/peng1233/offline-file-organizer.git
cd offline-file-organizer

git fetch ..\path\to\push-*.bundle main
# or: git fetch <bundlePath> main

git log --oneline --decorate -n 20

git push
```

Notes:
- `git bundle verify <bundlePath>` can be used to check integrity.
- The bundle method does not require any extra server-side setup.
