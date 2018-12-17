#!/bin/bash
# Environment
# ------------
LOCAL_USER=${LOCAL_USER:-undefined}
LOCAL_USER_GROUP=${LOCAL_USER_GROUP:-undefined}
LOCAL_USER_UID=${LOCAL_USER_UID:-1013}
LOCAL_USER_GID=${LOCAL_USER_GID:-1013}

if [[ "$LOCAL_USER" != "undefined" && $(getent passwd | grep -c "^${LOCAL_USER}:") == 0 ]]; then
    useradd -ms /bin/bash $LOCAL_USER
    

    if [[ "$LOCAL_USER_GROUP" != "undefined" && $(getent group $LOCAL_USER_GROUP) == 0 ]]; then
        groupadd --gid $LOCAL_USER_GID $LOCAL_USER_GROUP
    fi

    # Update uid/gid for created user
    OLD_LOCAL_USER_UID=$(id $LOCAL_USER -u)
    OLD_LOCAL_USER_GID=$(id $LOCAL_USER -g)

    if [[ "$OLD_LOCAL_USER_UID" != "$LOCAL_USER_UID" && "$OLD_LOCAL_USER_GID" != "$LOCAL_USER_GID" ]]; then 
        usermod --uid $LOCAL_USER_UID --gid $LOCAL_USER_GID $LOCAL_USER
    fi

    /bin/cp -af /root/{.bashrc,.gitconfig} "/home/${LOCAL_USER}/"
    chown -R "${LOCAL_USER_UID}:${LOCAL_USER_GID}" "/home/${LOCAL_USER}"
fi