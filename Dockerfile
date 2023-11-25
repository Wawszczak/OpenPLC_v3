FROM debian:bullseye-20231120
COPY ./*.sh /workdir/
WORKDIR /workdir
RUN mkdir /persistent
VOLUME /persistent
RUN ./install.sh docker InstallDeps
RUN ./install.sh docker InstallPyDeps
COPY ./utils /workdir/utils/
RUN ./install.sh docker InstallAllLibs
COPY ./webserver /workdir/webserver/
RUN ./install.sh docker Finalize
RUN touch /persistent/mbconfig.cfg
RUN touch /persistent/persistent.file
RUN mkdir /persistent/st_files
RUN cp /workdir/webserver/openplc.db /persistent/openplc.db
RUN mv /workdir/webserver/openplc.db /workdir/webserver/openplc_default.db
RUN cp /workdir/webserver/dnp3.cfg /persistent/dnp3.cfg
RUN mv /workdir/webserver/dnp3.cfg /workdir/webserver/dnp3_default.cfg
RUN cp /workdir/webserver/st_files/* /persistent/st_files
run mv /workdir/webserver/st_files /workdir/webserver/st_files_default
RUN ln -s /persistent/mbconfig.cfg /workdir/webserver/mbconfig.cfg
RUN ln -s /persistent/persistent.file /workdir/webserver/persistent.file
RUN ln -s /persistent/openplc.db /workdir/webserver/openplc.db
RUN ln -s /persistent/dnp3.cfg /workdir/webserver/dnp3.cfg
RUN ln -s /persistent/st_files /workdir/webserver/st_files

ENTRYPOINT ["./start_openplc.sh"]
