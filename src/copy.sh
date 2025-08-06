#!/bin/bash

scp /home/gitlab-runner/builds/C6ZFQPhv/0/students/DO6_CICD.ID_356283/mariahni/DO6_CICD-2/src/cat/s21_cat mariahni@10.10.0.2:/usr/local/bin
scp /home/gitlab-runner/builds/C6ZFQPhv/0/students/DO6_CICD.ID_356283/mariahni/DO6_CICD-2/src/grep/s21_grep mariahni@10.10.0.2:/usr/local/bin
ssh mariahni@10.10.0.2 ls -lah /usr/local/bin
