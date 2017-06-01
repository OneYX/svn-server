#!/bin/bash

if [ ! -d /var/svn/subversion ]; then
mkdir -p /var/svn/subversion
fi

if [ ! -d /var/svn/repoz ]; then
mkdir -p /var/svn/repoz
fi

if [ ! -d /var/svn/svnadmin ]; then
mkdir -p /var/svn/svnadmin
fi

if [ ! -f /var/svn/subversion/passwd ]; then
touch /var/svn/subversion/passwd
chmod -R 666 /var/svn/subversion/passwd
fi

if [ ! -f /var/svn/subversion/authz ]; then
touch /var/svn/subversion/authz
chmod -R 666 /var/svn/subversion/authz
fi

if [ ! -f /var/svn/subversion/dav_svn.conf ]; then
cp /etc/apache2/mods-available/dav_svn2.conf /var/svn/subversion/dav_svn.conf
fi
ln -s /var/svn/subversion/dav_svn.conf /etc/apache2/mods-available/dav_svn.conf

apache2
svnserve -d -r /var/svn/repoz
#bash
/bin/sh -c "while true; do sleep 1; done"


