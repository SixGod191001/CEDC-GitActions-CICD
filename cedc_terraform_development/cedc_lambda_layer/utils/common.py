import boto3

def get_current_account_number():
    sts_client = boto3.client('sts')
    response = sts_client.get_caller_identity()
    return response['Account']


def get_arn(service, resource):
    account_number = get_current_account_number()
    return f"arn:aws:{service}:ap-northeast-1:{account_number}:{resource}"
