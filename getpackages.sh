#!/bin/bash

dpkg-query -l | grep -v "^rc" > packages
