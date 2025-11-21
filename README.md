# Auto Web Login to School Internet

## For

For account-password-needed-only systems. Exempli gratia CJLU

## Usage

1. Visit gateway website to login
2. `F12` to open console, and switch to network page. clear all and refresh the page

   ![image-20251121121538693](./README.assets/image-20251121121538693.png)
3. Manually login with a wrong account-password (to have a easier test later without logout) A login request should occur in `network` page. Open it and check the `header`

   ![image-20251121121649055](./README.assets/image-20251121121649055.png)
4. Copy as `cURL`. And paste into the bash script, edit account and password.

   ![image-20251121121740520](./README.assets/image-20251121121740520.png)

   ![image-20251121121934501](./README.assets/image-20251121121934501.png)
5. Edit script path in `school_net_web_login.service`; Edit crontab config, run every 3 hour by default
6. Run bash script to login and enable systemd service and crontab task.

## OpenWRT config

1. After editing script with your own `cURL` command, upload the script to the router

    ```bash
    scp /path/to/script root@ip.to.your.router:~/web_login.bash
    ```

2. Login to the dashboard of OpenWRT

3. Add crontab task

   ![image-20251121122732105](./README.assets/image-20251121122732105.png)

   ```crontab
   00 */3 * * * /root/web_login.bash > /tmp/web_login_$(date --iso-8601=seconds).log
   ```

   

4. Add task on boot

   ![image-20251121122900641](./README.assets/image-20251121122900641.png)

5. Reboot the router or manually run script via SSH

