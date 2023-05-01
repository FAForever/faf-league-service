import re
import subprocess
from distutils.core import setup
from pathlib import Path

from setuptools import find_packages

import service


def get_version() -> str:
    output = subprocess.run(
        [
            "git", "--git-dir", Path(__file__).parent / ".git",
            "describe", "--tags"
        ],
        capture_output=True
    ).stdout.decode().strip().split("-")
    # Output is either 1.4.0 if the tag points to the current commit or
    # something like this 1.4.0-11-g3b467ad if it doesn't

    version = ".".join(re.findall(r"\d+", output[0])) or "0.dev"
    if len(output) > 1:
        return f"{version}+{output[-1]}"
    else:
        return version


setup(
    name="Forged Alliance Forever League Service",
    version=get_version(),
    packages=["service"] + find_packages(),
    url="http://www.faforever.com",
    license=service.__license__,
    author=service.__author__,
    author_email=service.__contact__,
    description="Service to provide leaderboards for Forged Alliance Forever",
    include_package_data=True,
)
