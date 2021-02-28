#! /bin/bash

set -e

echo ""
echo "This takes a ***long*** time - about an hour and ten minutes"
echo "on my AGX Xavier and nearly two hours on my 4 GB Nano! I run"
echo "it every time I update Julia, so you don't have to."
echo "Use Control-C to stop in the next 20 seconds if you wish."
sleep 20
echo "OK - stand by!"
sudo /usr/bin/time julia -e 'using Pkg; Pkg.test("CUDA")' \
  >> $EDGYR_LOGS/test-julia.log 2>&1

gzip -9 $EDGYR_LOGS/test-julia.log 2>&1
