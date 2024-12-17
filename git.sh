#!/bin/bash

confirm_local_changes="S"
if [[ "$confirm_local_changes" == "s" || "$confirm_local_changes" == "S" ]]; then
    git add .

    read -p "Describe brevemente los cambios realizados: " commit_message
    git commit -m "$commit_message"
    echo "Cambios locales añadidos y confirmados."
else
    echo "No se añadieron cambios locales."
fi

# Paso 2: Hacer pull para fusionar cambios remotos
echo "Haciendo git pull para actualizar cambios del repositorio remoto en el local..."
git pull

# Paso 3: Confirmar cambios resultantes después del pull
echo "Estado del repo:"
git status
read -p "Ya está actualizado el repo, vas a hacer cambios? (S/n): " confirm_after_pull
if [[ "$confirm_after_pull" == "s" || "$confirm_after_pull" == "S" ]]; then
    git add .
    read -p "Commit del cambio que vas a subir: " merge_message
    git commit -m "$merge_message"
fi

# Paso 4: Hacer push para subir los cambios al repositorio remoto
read -p "Confirmar el push que vas a hacer (S/n): " confirm_push
if [[ "$confirm_push" == "s" || "$confirm_push" == "S" ]]; then
    echo "Haciendo git push..."
    git push
else
    echo "No se subieron los cambios al repositorio remoto."
fi

echo "Script finalizado."
