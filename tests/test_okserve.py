import okserve


def test_version():
    version = okserve.__version__
    parts = version.split(".")
    assert len(parts) == 3
    assert all(p.isdigit() for p in parts)
