#Custom Profile file
# 1.0 initial version 
# 1.1 add alias
###################
version=1.2

export PS1='\u@\h:\w\n#'
export PATH=$PATH:$HOME/bin:/home/opc/bin

# 169.254.169.254 - Oracle cloud server for agent communication 
#
#display umask values
#umask -S
#umask=022 #default
umask 0027

# END

