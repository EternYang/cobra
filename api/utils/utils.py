from rest_framework import exceptions
from django.db.utils import IntegrityError
from django.core.exceptions import FieldError
from django.db import transaction
import time
from functools import wraps


def transaction_wrapper(func):
    def inner(*args, **kwargs):
        with transaction.atomic():
            ret = func(*args, **kwargs)
        return ret

    return inner


def except_validation_error(func):
    def inner(*args, **kwargs):
        try:
            ret = func(*args, **kwargs)
            return ret
        except KeyError as e:
            raise exceptions.ValidationError(detail={'KeyError': str(e), 'ReturnMessage': "Invalid input."})
        except IntegrityError as e:
            raise exceptions.ValidationError(detail={'IntegrityError': str(e), 'ReturnMessage': "Invalid input."})
        except FieldError as e:
            raise exceptions.ValidationError(detail={'FieldError': str(e), 'ReturnMessage': "Invalid input."})
        except Exception as e:
            raise e

    return inner


def get_sorted_key_func(order_field):
    def by_order_field(i):
        if not isinstance(i[order_field], (int, float)):
            return 0
        return i[order_field]

    return by_order_field


def fun_timer(function):
    @wraps(function)
    def function_timer(*args, **kwargs):
        t0 = time.time()
        result = function(*args, **kwargs)
        t1 = time.time()
        print(" Total time running %s: %s seconds" % (function, str(t1 - t0)))
        return result

    return function_timer
