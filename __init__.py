import hy
from trytond.pool import Pool
from . import hello


def register():
    Pool.register(
        hello.HelloTitle,
        hello.Hello,
        module='hello_title', type_='model')
