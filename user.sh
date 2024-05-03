# $1 client name
# $2 client last ip segment (10.77.77.X)
mkdir $1
wg genkey > $1/$1.key
cat $1/$1.key | wg pubkey > $1/$1.key.pub
PUBKEY=$(cat $1/$1.key.pub)
PRIVKEY=$(cat $1/$1.key)
SV_CONF=$1/$1.server.conf
CL_CONF=$1/$1.conf
SUB_NET="10.77.77."

echo "[peer]" > $SV_CONF
echo "PublicKey = $PUBKEY" >> $SV_CONF
echo "AllowedIPs = $SUB_NET$2" >> $SV_CONF
echo "" >> $SV_CONF

cat $SV_CONF >> share.conf

echo "[interface]" > $CL_CONF
echo "Address = $SUB_NET$2/32" >> $CL_CONF
echo "PrivateKey = $PRIVKEY" >> $CL_CONF
echo "" >> $CL_CONF
echo "[peer]" >> $CL_CONF
echo "PublicKey = $(cat share.key.pub)" >> $CL_CONF
echo "AllowedIPs = ${SUB_NET}0/24" >> $CL_CONF
echo "Endpoint = 34.139.14.91:19591" >> $CL_CONF

