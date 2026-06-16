# GitHub 업로드 가이드

이 폴더는 GitHub 업로드용으로 정리된 MOMONet 프로젝트입니다.

## 1. GitHub 저장소 만들기

GitHub에서 `New repository`를 누르고 저장소 이름을 입력합니다.

추천 이름:

```text
momonet-jsp-market
```

README, .gitignore, License는 체크하지 않고 생성하는 것을 추천합니다.

## 2. VS Code에서 폴더 열기

압축을 푼 뒤 VS Code에서 `momonet-jsp-market` 폴더를 엽니다.

## 3. 터미널에서 업로드

아래 명령어를 순서대로 입력합니다.

```bash
git init
git remote add origin https://github.com/깃허브아이디/momonet-jsp-market.git
git add .
git commit -m "Add MOMONet JSP market project"
git branch -M main
git push -u origin main
```

예시:

```bash
git remote add origin https://github.com/X0X1N/momonet-jsp-market.git
```

## 4. origin이 이미 있다고 나오는 경우

```bash
git remote set-url origin https://github.com/깃허브아이디/momonet-jsp-market.git
```

그다음 다시 push합니다.

```bash
git push -u origin main
```

## 5. 민감 정보 확인

업로드 전에 아래 명령어로 민감 정보가 남아있는지 확인합니다.

```bash
grep -R "sobin1641@" .
grep -R "dqqd" .
grep -R "YOUR_DB_PASSWORD" .
```

첫 번째와 두 번째 검색 결과는 아무것도 나오면 안 됩니다.
`YOUR_DB_PASSWORD`는 예시값이라 나와도 괜찮습니다.

## 6. 수정 후 다시 올리기

README나 코드를 수정했다면 아래 명령어를 사용합니다.

```bash
git add .
git commit -m "Update MOMONet project"
git push origin main
```
