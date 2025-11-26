from django import template



register = template.Library()

@register.filter
def batch(value, n):
    """Chia list thành các nhóm n phần tử"""
    result = []
    value = list(value)
    for i in range(0, len(value), n):
        result.append(value[i:i+n])
    return result