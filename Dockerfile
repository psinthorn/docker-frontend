#######################
# Stage 1 Build stage #
#######################

#Install base image and set name by as iteration
FROM node:alpine as builder

#Specific work directory on container
WORKDIR /app

#Copy package.js to to work directory
#Run npm install
COPY ./package.json ./
RUN npm install

#Copy all the file and folder from local dev folder to work directory on container
COPY ./ ./ 
#Build web app with 'npm run build' command
RUN npm run build



#######################
# Stage  Run stage #
#######################
#Install NGINX base image
FROM nginx
EXPOSE 80
#Copy build folde from build stage to nginx public folder
COPY --from=builder /app/build /usr/share/nginx/html
