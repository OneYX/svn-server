FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y apache2 subversion libapache2-svn libapache2-mod-php5

#RUN a2enmod dav_svn

# Redirect to the SVN from APACHE root
RUN echo '<html><head><meta http-equiv="refresh" content="0; URL=svn/"></head><body></body></html>' > /var/www/html/index.html 

# APACHE environment variables
ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_LOCK_DIR  /var/lock
ENV APACHE_PID_FILE  /var/run/apache2.pid

# Create a repository directory
RUN mkdir -p /var/svn
RUN mkdir -p /var/svn/subversion
RUN mkdir -p /var/svn/repoz
RUN mkdir -p /var/svn/svnadmin

# Set permissions
RUN addgroup subversion
RUN usermod -a -G subversion www-data
RUN chown -R www-data:subversion /var/svn
RUN chmod -R g+rws /var/svn


# Configure Apache to serve up Subversion
ADD dav_svn.conf /etc/apache2/mods-available/dav_svn2.conf
RUN rm /etc/apache2/mods-available/dav_svn.conf

## Create password & authentication file
#RUN touch /var/svn/subversion/passwd
#RUN touch /var/svn/subversion/authz
#RUN chmod -R 666 /var/svn/subversion/passwd
#RUN chmod -R 666 /var/svn/subversion/authz

# Install iF.SVNAdmin - Web-based GUI to manage Subversion
ADD svnadmin-1.6.2-raykuo.tar /var/www/html

#########################################
ADD sudoers /etc/sudoers
RUN chmod 440 /etc/sudoers
#########################################

WORKDIR /var/svn

EXPOSE 80 
EXPOSE 3690

ADD startup.sh /startup.sh
RUN chmod 755 /startup.sh

CMD ["/startup.sh"]


