# Auto Web Login to School Internet

## For

For account-password-needed-only systems. E.g. CJLU

## Usage

1. Visit gateway website to login
2. `F12` to open console, and switch to network page. clear all and refresh the page
3. Manually login with a wrong account-password (to have a easier test later without logout)
4. Then a login request should occur in `network` page. Open it and check the `header`
5. Copy as cURL. And paste into the bash script
6. Edit script path in `school_net_web_login.service`; Edit crontab config, run every 3 hour by default
7. 
