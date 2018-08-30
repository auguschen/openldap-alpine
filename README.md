# openldap-alpine

docker iamge openldap server on alpine linux
and it is for personal purpose

## environment variables

直接用环境变量赋值，或者讲值保存在相应文件里，用*_PATH变量来指定

- SUFFIX  
  suffix信息
  
- ROOTDN  
  rootdn信息

- ROOTPW  
  rootpw信息

- SUFFIX_PATH  
  包含suffix信息的文件的路径

- ROOTDN_PATH  
  包含rootdn信息的文件的路径

- ROOTPW_PATH  
  包含rootpw信息的文件的路径

- ERRLVL  
  LDAP服务器日志输出参数，不指定此参数默认使用256

## defined volumes

- /etc/openldap
- /var/lib/openldap/openldap-data