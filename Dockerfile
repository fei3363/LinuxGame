FROM ubuntu:20.04
  
RUN apt-get update && apt-get install -y openssh-server
RUN apt-get install -y procps
RUN apt-get install -y sudo
RUN apt-get install -y curl

RUN mkdir /var/run/sshd
RUN echo 'root:feifeiP@ssword!' | chpasswd
RUN sed -ri 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

RUN /etc/init.d/ssh start

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN useradd -rm -d /home/fei -s /bin/bash -g root -G sudo -u 1001 fei -p feifeiP@ssword!
RUN echo 'fei:feifeiP@ssword!' | chpasswd

RUN echo "flag{cat_lookmetxt}\n勇者好，歡迎光臨 Linux 異世界\n也許當你打開這個文件的時候\n你是失憶的狀態\n你可以看看歷史紀錄\n如果有什麼疑難雜症歡迎問男人 man" > /root/lookme.txt
RUN echo "flag{cat_lookmetxt}\n勇者好，歡迎光臨 Linux 異世界\n也許當你打開這個文件的時候\n你是失憶的狀態\n你可以看看歷史紀錄\n如果有什麼疑難雜症歡迎問男人 man" > /home/fei/lookme.txt


RUN echo "flag{The_bash_history_is_located_under_~/.bash_history}\ncd /tmp\ncat next.txt\n" > /root/.bash_history
RUN echo "flag{The_bash_history_is_located_under_~/.bash_history}\ncd /tmp\ncat next.txt\n" > /home/fei/.bash_history
RUN echo "flag{cd_test}\n勇者你似乎使用了 cd 指令切換資料夾\n那你可以利用 find 找到寶藏的位置\ntreasure.txt" > /tmp/next.txt

RUN useradd -MN FLAGIS_etcpasswd_and_system_log
RUN useradd -rm -d /home/wendy -s /bin/bash -g root -G sudo  wendy -p wendyP@ssw0rd
RUN echo 'wendy:wendyP@ssw0rd' | chpasswd


RUN echo "flag{good_at_find_file}\nHI 我是 Wendy 我放了一個壓縮檔在這裡\n你能解開壓縮檔嗎" > /home/wendy/treasure.txt
COPY wendy.tar.gz /home/wendy/


RUN echo "flag{log_file}\n" > /var/log/logflag.txt
  
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
