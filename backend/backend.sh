# dependencies
sudo yum install git -y

wget https://dl.google.com/go/go1.13.9.linux-amd64.tar.gz
tar xf go1.13.9.linux-amd64.tar.gz
sudo mv go /usr/local/go-1.13
export GOROOT=/usr/local/go-1.13
export PATH=$GOROOT/bin:$PATH
which go

# app itself
cd ../
rm -rf database-forum/
git clone https://github.com/labzunova/database-forum
cd database-forum/
go run cmd/main.go
