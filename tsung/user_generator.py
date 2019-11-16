"""
USAGE: python user_generator.py <#users>
Generate a 'userlist.csv' with <#users> rows of users
of the format:
user0;user0@example.com
...
user999;user999@example.com
"""

import sys

f = open("userlist.csv", "w")

for i in range(int(sys.argv[1])):
    f.write("user{};user{}@example.com\n".format(str(i), str(i)))

f.close()