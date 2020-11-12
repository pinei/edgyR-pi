#! /bin/bash

set -e

echo ""
echo "This takes a ***long*** time - about an hour and ten minutes"
echo "on my AGX-Xavier! I run it every time I update Julia, so you"
echo "don't have to."
echo "Use Control-C to stop in the next 20 seconds if you wish."
sleep 20
echo "OK - stand by!"
sudo julia -e 'using Pkg; Pkg.test("CUDA")'
