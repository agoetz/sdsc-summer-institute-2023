### SDSC Summer Institute 2023 
# Session 1.0 Preparation Day


**Date: Wednesday, August 2nd, 2023**


## Welcome & Orientation
[Robert Sinkovits, Director of Education and Training](https://www.sdsc.edu/research/researcher_spotlight/sinkovits_robert.html)


## Accounts, Login, Environment, Running Jobs and Logging into Expanse User Portal
Marty Kandes, Computational & Data Science Research Specialist, HPC User Services Group

In this virtual session, we'll familiarize you with logging into Expanse with your training account both via the Expane User Portal and directly via SSH. We'll also have you run and test some of the command aliases we've setup in your environment on Expanse to make your hands-on sessions next week at the Summer Institute go more smoothly. 

### Getting your training account and password

You should have received an email with the subject line: **HPC & DS 2023 Summer Institute: Account Set-Up**. The content of the email should be as follows:

```
Your personalized account information is given below.

Your password is made available through a one-time URL. Be sure to securely record your password immediately since you will not be able to access the URL a third time.

The one-time URL will expire after 14 days, or after 2 viewings, whichever comes first.


    Username: trainXXX (or etrainXXX)
    URL to retrieve password: https://pwpush.security.sdsc.edu/XXXXXXXXXXXXXXXXXXXXXXXXXXXXX


As a reminder, we are asking all attendees to use the training accounts that we are providing, even if you already have your own account. This will minimize problems related to custom configurations (e.g. environment variables, choice of shell, etc.) that may cause some of the hands-on examples to break.

This training account may be used:
  * Via SSH directly to login.expanse.sdsc.edu
  * Via a special page on the Expanse Portal: https://portal.expanse.sdsc.edu/training

For any account user issues/questions, contact consult@sdsc.edu. 
```

If you are no longer able to retrieve your password and/or have forgotten the password, please let us know in the Zoom chat. We will resend you a new password as soon as possible.

### Login to the Expanse User Portal

Once you have your training account username and password, please open your favorite web broswer to the [Expanse User Portal](https://portal.expanse.sdsc.edu/training) and attempt to login. If you are unable to login to the portal, please let us know in the Zoom chat. We may need to help you debug the problem. Please note, however, restarting your web browser in private mode is typically the first quick fix  we'll try.

If you're able to login successfully, please feel free to explore what's available via portal. You can find the portal's **Online Documentation** under the **Help** tab in the upper right of the dashboard. We'll do a quick tour of the portal as well once we get everyone logged in. 

### Login to Expanse via SSH.

After you're done exploring the Expanse User Portal, please also attempt to login directly to Expanse via SSH. 
```
ssh trainXXX@login.expanse.sdsc.edu
```
You should be prompted for the same password you used to login to the portal. 

It's possible that we may experience an outage of the portal during the Summer Institute, so it's good to also make sure you have direct access via SSH. Or maybe you, like me, prefer to work from a standard terminal application. 

If you are a *Windows* user, the easiest way to get started with SSH may be by setting up the [OpenSSH Client in PowerShell](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui). You can also use a more traditional SSH client like [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html). However, if you have the time, then I would recommend you setup the [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/) , which will provide you with a GNU/Linux environment -- including most command-line tools, utilities, and applications -- directly from your standard Windows machine.

### Let's test your environment

From either the Expanse User Portal or your terminal, we want to run a few command aliases we've setup in your environment on Expanse to make the hands-on sessions next week go more smoothly. You can find these command aliases in your `.bashrc` file.

```
[train108@login02 ~]$ cat .bashrc
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Define common allocation and job-related environment variables
declare -xr SI23_ACCOUNT='gue998'
declare -xr SI23_RES_CPU='hpcds23cpu0'
declare -xr SI23_RES_GPU='hpcds23gpu0'
declare -xr SI23_QOS_CPU='normal-eot'
declare -xr SI23_QOS_GPU='gpu-shared-eot'

# Define pre-staged container and data directories
declare -xr SI23_CONTAINER_DIR='/cm/shared/apps/containers/singularity'
declare -xr SI23_DATA_DIR='/cm/shared/examples/sdsc/si/2023'

# Define srun-based interactive job command aliases
alias srun-shared="srun --account=${SI23_ACCOUNT} --reservation=${SI23_RES_CPU} --partition=shared --nodes=1 --ntasks-per-node=1 --cpus-per-task=4 --mem=16G --time=04:00:00 --pty --wait=0 /bin/bash"
alias srun-compute="srun --account=${SI23_ACCOUNT} --reservation=${SI23_RES_CPU} --partition=compute --qos=${SI23_QOS_CPU} --nodes=1 --ntasks-per-node=1 --cpus-per-task=128 --mem=243G --time=04:00:00 --pty --wait=0 /bin/bash"
alias srun-gpu-shared="srun --account=${SI23_ACCOUNT} --reservation=${SI23_RES_GPU} --partition=gpu-shared --qos=${SI23_QOS_GPU} --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 --mem=92G --gpus=1 --time=04:00:00 --pty --wait=0 /bin/bash"

# Prepend the GALYLEO_INSTALL_DIR to each user's PATH
export PATH="/cm/shared/apps/sdsc/galyleo:${PATH}"

# Define galyleo-based Jupyter notebook session command aliases
alias jupyter-shared-spark="galyleo launch --account ${SI23_ACCOUNT} --reservation ${SI23_RES_CPU} --partition shared --cpus 4 --memory 16 --time-limit 04:00:00 --env-modules singularitypro --sif ${SI23_CONTAINER_DIR}/spark/spark-latest.sif --bind /cm,/expanse,/scratch --quiet"
alias jupyter-compute-tensorflow="galyleo launch --account ${SI23_ACCOUNT} --reservation ${SI23_RES_CPU} --partition compute --qos ${SI23_QOS_CPU} --cpus 128 --memory 243 --time-limit 04:00:00 --env-modules singularitypro --sif ${SI23_CONTAINER_DIR}/tensorflow/tensorflow-latest.sif --bind /cm,/expanse,/scratch --quiet"
alias jupyter-gpu-shared-tensorflow="galyleo launch --account ${SI23_ACCOUNT} --reservation ${SI23_RES_GPU} --partition gpu-shared --qos ${SI23_QOS_GPU} --cpus 10 --memory 92 --gpus 1 --time-limit 04:00:00 --env-modules singularitypro --sif ${SI23_CONTAINER_DIR}/tensorflow/tensorflow-latest.sif --bind /cm,/expanse,/scratch --nv --quiet"
alias jupyter-compute-keras-nlp="galyleo launch --account ${SI23_ACCOUNT} --reservation ${SI23_RES_CPU} --partition compute --qos ${SI23_QOS_CPU} --cpus 128 --memory 243 --time-limit 01:30:00 --conda-env keras-nlp --conda-yml keras-nlp.yaml --mamba --quiet"
[train108@login02 ~]$
```

If you are unable to run any of the command aliases we are testing, please let us know in the Zoom chat. 

### Setting up SSH keys

And finally, the last thing we'll do today is show you [how to setup SSH keys](https://github.com/sdsc/sdsc-summer-institute-2022/blob/main/2.5_data_management/SSH.md#easy-access-setting-up-ssh-keys-key), which might help make the login proccess next week be less cumbersome for you. The tutorial in the works here loosely follows this one from [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04).

Additional Notes:
- https://github.com/sdsc/sdsc-summer-institute-2022/tree/main/1.0_preparation_day_welcome_and_orientation
- https://education.sdsc.edu/training/interactive/202208_sdscsi/section1_1/
- https://education.sdsc.edu/training/interactive/202208_sdscsi/section1_2/
