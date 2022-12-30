from setuptools import setup, find_packages

with open("requirements.txt") as f:
    req = f.read().splitlines()
    requirements = []
    extra_deps = []
    for i in range(len(req)):
        if req[i].startswith("https"):
            extra_deps.append(req[i])
        elif req[i] != "":
            requirements.append(req[i])

setup(
    name="kindletoorg",
    version="0.1.0",
    author="Kevin Lyter",
    author_email="IDK",
    packages=["kindletoorg"],
    description="Convert between Kindle clippings and org mode",
    classifiers=[
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.7",
    setup_requires=[],
    scripts=["./scripts/kindle2org"],
    install_requires=requirements,
    dependency_links=extra_deps,
)
