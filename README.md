## checkServer

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/aleen42/checkServer/master/LICENSE) ![](https://img.shields.io/badge/Shell-4,685-89e051.svg)

**checkServer** is a repository of a shell script snippet, which is mainly used for checking whether **CPU** or **MEMORY** of a server is normal. To enhance notification, the checked status will also be sent by emails.

### 1. Mutt

For mailing people, **Mutt** is the client what I chose for sending emails under Linux with **POP3** protocol. the following tutorial has shown us how to install it under Ubuntu. For more detailed around installation on other Linux, like CentOS, please check [the official site](http://www.mutt.org/), or [a third-party document](http://www.wilf.cn/post/centos-mutt-msmtp-setup.html) searched before.

#### 1.1 Installation via `apt-get`

The system name can be set with whatever name you like.

```bash
apt-get install mutt
```

#### 1.2 Setup Configuration

Touch a file named `.muttrc` in the `~` directory of root user and edit it with following snippet:

```
# .mutttrc file
# sudo vi ~/.muttrc or /root/.muttrc
set envelope_from=yes
# the name of who sent the mail
set from=xxx@xx.cn
# the real name of who send the mail
set realname="VoiceIn Website"
set use_from=yes
set rfc2047_parameters=yes
set charset="utf-8"
```

#### 1.3 Send Emails via Terminals

```bash
echo "Email Contents" | `which mutt` -s "Title" aleen42@vip.qq.com
```

### 2. Crontab

**Crontab** helps us to set up a series of tasks, which can be run at a fixed time in Linux.

The following case set here means that `checkServer.sh` will be executed on 9 pm every day.

```
0 21 * * * sh ./checkServer.sh false
```

### 3. Scripts Information

There is also some helpful information for you to understand shell scripts.

#### 3.1 Parameters

- **MAX_mem**(%): the upper edge of physical memory warning.
- **MAX_cpu**(%): the upper edge of physical cpu warning.
- **DELAY**(s): update every ***$delay*** seconds.
- **COUNT**: update ***$count*** times.
- **NORMAL_CHECK**: to identify whether it is just a normal check each day.
- **sh_command**: point out where `sh` command is.
- **top_command**: point out where `top` command is.
- **sar_command**: point out [where `sar` command is.
- **iostat_command**: point out where `iostat` command is.
- **free_command**: point out where `free` command is.

#### 3.2 Methods

- **checkServer**: generate system information and send emails to the specified email address.

#### 3.3 Extracting Number

To extracting number from terminals, I have used `sed` (The following case has got the row 3 and column 3 of results run by `top` command):

```bash
free | sed -n "3, 1p" | awk '{print int($3)}'
```

#### 3.4 Attention

`sar` command need us to set `ENABLED` with `true` in the configuration file `/etc/default/sysstat`.

```
#
# Default settings for /etc/init.d/sysstat, /etc/cron.d/sysstat
# and /etc/cron.daily/sysstat files
#

# Should sadc collect system activity informations? Valid values
# are "true" and "false". Please do not put other values, they
# will be overwritten by debconf!
ENABLED="true"

# Additional options passed to sa1 by /etc/init.d/sysstat
# and /etc/cron.d/sysstat
# By default contains the `-S DISK' option responsible for
# generating disk statisitcs.
SA1_OPTIONS="-S DISK"

# Additional options passed to sa2 by /etc/cron.daily/sysstat.
SA2_OPTIONS=""
```

Otherwise, we may get the following error when running `sar` command:

```
root@xxx:/home/checkServer# sar
Cannot open /var/log/sysstat/sa16: No such file or directory
Please check if data collecting is enabled in /etc/default/sysstat
```

### 4. How to install it on your server?

1. clone it:

    ```bash
    git clone https://github.com/aleen42/checkServer.git
    ```

2. install mutt service as mentioned [above](#1-mutt) and check whether the following commands works:

    ```bash
    mutt
    ```

    ```bash
    sar
    ```

3. run it manually:

    ```bash
    # options:
    #	- true: normal check
    #	- false: warning check
    # email_addr: the email you want to receive infos of the server
    sh ./checkServer.sh true aleen42@vip.qq.com
    ```

### :fuelpump: How to contribute

Have an idea? Found a bug? See [how to contribute](https://aleen42.github.io/PersonalWiki/contribution.html).

### :scroll: License

[MIT](https://aleen42.github.io/PersonalWiki/MIT.html) © aleen42
