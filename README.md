# SQR_IOS

## Quick start
* Clone repo
  ```Shell
  git clone https://github.com/KamilKhairullin/SQR_IOS.git
  ```
* Open IOS-MovieRecommendation.xcodeproj in Xcode
* Run project (Play button / CMD + R)

## Set up git-hooks
* Install git-format-staged
Requires Python version 3 or 2.7.

Install as a development dependency in a project that uses npm packages:

```Shell
npm install --save-dev git-format-staged
```
Or install globally:

```Shell
$ npm install --global git-format-staged
  ```

* Enable the hook by typing in the terminal inside project folder
```Shell
chmod +x .git/hooks/pre-commit 
```
The pre-commit hook will now run whenever you run git commit. Running git commit --no-verify will skip the pre-commit hook.