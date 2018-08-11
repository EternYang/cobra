from django.dispatch import receiver
from django.db.models.signals import post_save
from app01 import models
from rest_framework import serializers


class WalletSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Wallet
        fields = '__all__'


@receiver(post_save, sender=models.Member, dispatch_uid='init_wallet_for_each_member')
def init_wallet(sender, instance, created, **kwargs):
    if models.Wallet.objects.filter(member=instance).exists():
        return
    serializer = WalletSerializer(data={'member': instance.pk})
    serializer.is_valid(raise_exception=True)
    serializer.save()
