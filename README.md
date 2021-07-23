# README

## Create a windows VM via aws console (region - us-east-1)

1. Run `./init.sh` to create a windows server and linux instance with jenkins and ansible installed.
2. Access jenkins at port 8080 with jenkins vm IP.
3. Get admin password from /var/lib/jenkins/secrets/initialAdminPassword.
4. Login with admin password
5. Install suggessted plugins and continue with admin user.
6. Install ansible plugin
7. Create a new jenkins pipeline job with jenkinsfile from https://github.com/sowjanya2801/kaseya-test.git
8. Execute the job by passing windows vm user, password and ip as build parameters.
