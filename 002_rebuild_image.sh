#!/bin/bash

(cd ./Docker/Mainframe; ./00_remove_image.sh)
(cd ./Docker/Mainframe; ./01_build_image.sh)
