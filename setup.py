from distutils.core import setup

from setuptools import find_packages

import service

setup(
    name="Forged Alliance Forever League Service",
    version="1.3.0",
    packages=["service"] + find_packages(),
    url="http://www.faforever.com",
    license=service.__license__,
    author=service.__author__,
    author_email=service.__contact__,
    description="Service to provide leaderboards for Forged Alliance Forever",
    include_package_data=True,
)
