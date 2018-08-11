from django.db.models import Q


def get_page(request, page_size):
    try:
        page_size = int(request.GET.get('page_size', page_size))
        page = int(request.GET.get('page', 1))
        if page_size <= 0 or page <= 0:
            raise Exception()
    except Exception:
        page_size = page_size
        page = 1
    return (page_size, page)

# def get_q(request, connector, date_field, *fields, custom=False):
#     """
#     处理URL的filter字段，返回Q对象
#     :param request:
#     :return: Q对象
#     """
#     url_param_dict = request.GET
#     con = Q()
#     con.connector = connector  # AND/OR
#     from_date = url_param_dict.get('from')
#     to_date = url_param_dict.get('to')
#     if from_date and to_date:
#         con.children.append(('%s__range' % date_field, (from_date, to_date)))
#     elif from_date:
#         con.children.append(('%s__gte' % date_field, from_date))
#     elif to_date:
#         con.children.append(('%s__lte' % date_field, to_date))
#     for field in fields:
#         value = url_param_dict.get(field)
#         if value:
#             con.children.append((field, value))
#     return con
